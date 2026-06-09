import os
import re

base = r'F:\Users\code_data\vibe\CAS_learn\examples'

def find_plot_sections(lines):
    """Find line ranges of plotting sections."""
    sections = []
    i = 0
    while i < len(lines):
        line = lines[i].strip()
        # Look for section headers with %%
        if line.startswith('%%'):
            title = line.lower()
            is_plot = any(kw in title for kw in [
                'plot', 'figure', '图', '绘图', '可视化', 'visualization',
                'graphic', 'chart', 'save', '保存', 'headless',
                'frequency response', 'wave equation', '3d surface',
                'parametric curve', 'implicit function', 'function plot',
                'basic functions', 'multi-function', 'comparison'
            ])
            if is_plot:
                start = i
                # Find end: next %% section or end of file
                j = i + 1
                while j < len(lines):
                    if lines[j].strip().startswith('%%') and j > i:
                        break
                    j += 1
                # Include trailing blank lines
                while j > start and lines[j-1].strip() == '':
                    j -= 1
                sections.append((start, j))
                i = j
                continue
        i += 1
    return sections

def remove_standalone_plot_lines(lines):
    """Remove standalone plotting lines not in sections."""
    plot_re = re.compile(r'^\s*(figure|plot|subplot|fplot|contour|surf|mesh|xlabel|ylabel|title|legend|grid on|hold on|hold off|axis|colorbar|colormap|print\(|saveas|set\(0,.*DefaultFigureVisible)')
    
    result = []
    i = 0
    while i < len(lines):
        line = lines[i]
        stripped = line.strip()
        
        # Skip empty lines between plot commands
        if not stripped:
            # Check if surrounded by plot lines
            prev_plot = i > 0 and plot_re.match(lines[i-1].strip()) if i > 0 else False
            next_plot = False
            j = i + 1
            while j < len(lines) and not lines[j].strip():
                j += 1
            if j < len(lines):
                next_plot = bool(plot_re.match(lines[j].strip()))
            if prev_plot and next_plot:
                i += 1
                continue
        
        if plot_re.match(stripped):
            # Check if this is part of a larger block
            # Look ahead for more plot lines
            block_size = 1
            k = i + 1
            while k < len(lines):
                if plot_re.match(lines[k].strip()):
                    block_size += 1
                    k += 1
                elif lines[k].strip() == '':
                    k += 1
                else:
                    break
            
            if block_size >= 2:
                # Skip the entire block
                i = k
                continue
        
        result.append(line)
        i += 1
    
    return result

total_fixed = 0
for root, dirs, files in os.walk(base):
    for f in files:
        if not f.endswith('.m'):
            continue
        path = os.path.join(root, f)
        with open(path, 'r', encoding='utf-8') as fh:
            lines = fh.readlines()
        
        original_len = len(lines)
        
        # Find and remove plotting sections
        sections = find_plot_sections(lines)
        if sections:
            # Remove sections in reverse order
            for start, end in reversed(sections):
                del lines[start:end]
        
        # Remove standalone plotting lines
        lines = remove_standalone_plot_lines(lines)
        
        if len(lines) != original_len:
            total_fixed += 1
            with open(path, 'w', encoding='utf-8') as fh:
                fh.writelines(lines)
            rel = os.path.relpath(path, base)
            removed = original_len - len(lines)
            print(f'Fixed: {rel} (removed {removed} lines)')

print(f'\nTotal files fixed: {total_fixed}')
