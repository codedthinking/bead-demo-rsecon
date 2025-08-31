clear all
set more off

* Read the raw file as string - use tab as delimiter (which shouldn't appear in ls output)
import delimited using "stats.txt", ///
    delimiter("\t") varnames(nonames) stringcols(_all) clear

* Count total lines imported
display "Total lines imported: " _N

* Keep only lines that start with permission flags (- or d followed by rwx pattern)
keep if regexm(v1, "^[d-][rwx-]{9}")
display "Lines after keeping permission flags: " _N

* Parse each line - the format is:
* permissions links owner group size month day time/year filename
* After the year/time, everything else is the filename

gen perm = regexs(1) if regexm(v1, "^([d-][rwx-]{9}\+?)")

* Extract size (number before the month)
gen size = real(regexs(1)) if regexm(v1, " ([0-9]+) +(Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec) ")

* Extract owner (word after links number and before group)
gen owner = word(regexs(1), 3) if regexm(v1, "^[d-][rwx-].* +([0-9]+ +[a-z]+ +[a-z]+) ")

* Extract filename - the last space-separated field that ends with .zip, .xmeta, or .dot
gen filename = ""
* Method: find everything after the last space before the file extension
gen temp_line = v1
* For lines with time (HH:MM), extract everything after it
replace filename = regexs(1) if regexm(temp_line, "[0-9]{2}:[0-9]{2} +(.+\.(zip|xmeta|dot))$")
* For lines with year, extract just the filename (not the date parts)
replace filename = regexs(2) if regexm(temp_line, "(Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec) +[0-9]+ +[0-9]{4} +(.+\.(zip|xmeta|dot))$") & filename==""
drop temp_line

* Keep only regular files (those starting with -)
keep if substr(perm,1,1)=="-"
display "Regular files: " _N

* Check how many have filenames
count if filename != ""
display "Files with filenames: " r(N)

* Save intermediate file for debugging
preserve
keep if filename != ""
export delimited using "debug_filenames.csv", replace
restore

* Keep only .zip files in the main bead-box directory listing
keep if regexm(filename, "\.zip$")
display "ZIP files: " _N

* Extract timestamp from filename  
* Pattern: anything_YYYYMMDDTnnnnnnnnnnnnnn+/-ZZZZ.zip where n is 12-18 digits
gen timestamp = regexs(1) if regexm(filename, "_([0-9]{8}T[0-9]+[\+\-][0-9]{4})\.zip")
gen name = regexs(1) if regexm(filename, "^(.+)_[0-9]{8}T[0-9]+[\+\-][0-9]{4}\.zip")

* Clean up
drop v1 perm

* Convert size to double for large file sizes
recast double size
format size %15.0fc

* Parse timestamp into Stata datetime
* Format: YYYYMMDDTHHMMSSμμμμμμμμμ+ZZZZ
* Extract components
gen year = real(substr(timestamp, 1, 4))
gen month = real(substr(timestamp, 5, 2))
gen day = real(substr(timestamp, 7, 2))
gen hour = real(substr(timestamp, 10, 2))
gen minute = real(substr(timestamp, 12, 2))
gen second = real(substr(timestamp, 14, 2))

* Create datetime variable (milliseconds since 1960)
gen double datetime = mdyhms(month, day, year, hour, minute, second)
format datetime %tc

* Extract timezone offset
gen timezone = substr(timestamp, 27, 5)

* Order variables
order name datetime timezone owner size filename timestamp
drop year month day hour minute second

* Label variables
label variable name "Dataset name"
label variable datetime "Creation datetime"
label variable timezone "Timezone offset"
label variable owner "File owner"
label variable size "File size (bytes)"
label variable filename "Full filename"
label variable timestamp "Original timestamp"

* Save dataset
save stats.dta, replace
export delimited using "stats.csv", replace

* Display summary
count
describe name datetime size
summarize size, detail
summarize datetime, detail format

* Show some examples
list name datetime size in 1/5, abbreviate(15)

* Check for parsing issues
count if missing(datetime)
if r(N) > 0 {
    display "Warning: " r(N) " files have missing datetime"
    list name timestamp filename if missing(datetime) in 1/5
}

egen n_versions = total(1), by(name)
egen name_tag = tag(name)
tabulate n_versions if name_tag 

summarize n_versions if name_tag

summarize size, detail

bysort name (datetime): generate index = _n
egen i = group(name)
xtset i index
generate gap = (D.datetime)/1000 / 3600 / 24

summarize gap if gap > 0, detail