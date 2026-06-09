import os
import sys

# Fix calculus_of_variations.mac
path1 = r'F:\Users\code_data\vibe\CAS_learn\examples\05-functional-analysis\maxima\calculus_of_variations.mac'
with open(path1, 'r', encoding='utf-8') as f:
    content = f.read()

# Replace subst with direct calculation
old1 = """EL_check: ratsimp(subst(q(t)=q_sol,
            diff(q(t), t)=diff(q_sol, t),
            diff(q(t), t, 2)=diff(q_sol, t, 2),
            m*diff(q(t), t, 2) + k*q(t)))"""
new1 = "EL_check: ratsimp(m*diff(q_sol, t, 2) + k*q_sol)"

if old1 in content:
    content = content.replace(old1, new1)
    with open(path1, 'w', encoding='utf-8') as f:
        f.write(content)
    print('Fixed: calculus_of_variations.mac')
else:
    print('WARNING: pattern not found in calculus_of_variations.mac')
    # Show context around subst
    lines = content.split('\n')
    for i, line in enumerate(lines):
        if 'subst' in line:
            print(f'  Line {i+1}: {line}')

# Fix mechanics_applications.mac
path2 = r'F:\Users\code_data\vibe\CAS_learn\examples\05-functional-analysis\maxima\mechanics_applications.mac'
with open(path2, 'r', encoding='utf-8') as f:
    content = f.read()

replacements = [
    ('(sin(theta) ~ theta):', '(sin(theta) ~~ theta):'),
    ('(sin(theta) ~ theta - theta^3/6):', '(sin(theta) ~~ theta - theta^3/6):'),
    ('T ~ T_0', 'T ~~ T_0'),
    ('T ~ ~,4f', 'T ~~,4f'),
    ('T^2 ~ r_0^3', 'T^2 ~~ r_0^3'),
]

count = 0
for old, new in replacements:
    if old in content:
        content = content.replace(old, new)
        count += 1
        print(f'  Replaced: {old!r} -> {new!r}')

if count > 0:
    with open(path2, 'w', encoding='utf-8') as f:
        f.write(content)
    print(f'Fixed: mechanics_applications.mac ({count} replacements)')
else:
    print('WARNING: no patterns found in mechanics_applications.mac')
