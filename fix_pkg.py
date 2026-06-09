import os

base = r'F:\Users\code_data\vibe\CAS_learn\examples'
count = 0
for root, dirs, files in os.walk(base):
    for f in files:
        if not f.endswith('.m'):
            continue
        path = os.path.join(root, f)
        with open(path, 'r', encoding='utf-8') as fh:
            lines = fh.readlines()
        new_lines = [l for l in lines if 'pkg load symbolic' not in l]
        if len(new_lines) != len(lines):
            count += 1
            with open(path, 'w', encoding='utf-8') as fh:
                fh.writelines(new_lines)
            print('Fixed: ' + f)
print('Total: ' + str(count))
