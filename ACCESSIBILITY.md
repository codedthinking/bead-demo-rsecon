# Accessibility Setup for bead Presentation

## Overview

All accessibility features are contained in `accessibility.html` which provides:

- Screen reader support
- Keyboard navigation enhancements  
- Skip navigation for demo section
- High contrast mode support
- Reduced motion support

## Configuration

Edit the configuration at the top of `accessibility.html`:

```javascript
const A11Y_CONFIG = {
  demoStart: 14,  // First slide of demo section
  demoEnd: 176,   // Last slide of demo section
  skipKey: 's',   // Alt+S to skip demo
  debug: false    // Set to true for console logging
};
```

## Usage

1. The main presentation file (`39-bead.qmd`) includes:
   ```yaml
   include-after-body:
     - file: terminal.html
     - file: accessibility.html
   ```

2. For terminal elements in `krisztian.qmd`, add ARIA attributes directly:
   ```html
   <div class="terminal" role="region" aria-label="Terminal step 1" tabindex="0">
     <span class="prompt" aria-hidden="true">/demo $ </span>
     <span class="command" aria-label="Command: setup">: Setup</span>
     <span class="cursor" aria-hidden="true"></span>
   </div>
   ```

## Features

### For Screen Reader Users
- **Alt+S**: Skip demo section (configurable)
- All terminal content properly labeled
- Navigation instructions announced
- Focus indicators on all interactive elements

### For Keyboard Users
- Tab through all interactive elements
- Clear focus indicators
- Skip links for long sections

### For Motion-Sensitive Users
- Respects `prefers-reduced-motion`
- Disables animations while preserving content

### For Low Vision Users
- High contrast mode support
- Clear focus indicators
- Scalable interface

## Testing

1. **Screen Reader**: 
   - macOS: Cmd+F5 for VoiceOver
   - Check Console for "Accessibility features initialized"

2. **Keyboard Navigation**:
   - Tab through all elements
   - Test Alt+S during demo section

3. **Browser DevTools**:
   - Check Accessibility tree
   - Run Lighthouse audit

## Maintenance

All accessibility code is in `accessibility.html`. To modify:

1. Update configuration values
2. Modify CSS in `<style>` section
3. Modify JavaScript in `<script>` section
4. Rebuild: `make 39-bead.html`

## Notes

- The solution works with Quarto's self-contained mode
- ARIA attributes should be added directly to HTML elements in source files
- The skip navigation only appears during the demo section