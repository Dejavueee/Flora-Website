
import os

file_path = r'c:\Users\Lenovo\Desktop\flora website\alefox-clone-index-2\index.html'

with open(file_path, 'r', encoding='utf-8') as f:
    lines = f.readlines()

# Define the start markers for each section in their CURRENT order
markers = [
    ('start', 0), # Placeholder for start of file
    ('feature', '<section class="feature-one">'),
    ('about', '<section class="about-two">'),
    ('clients', '<div class="client-carousel client-carousel--two'),
    ('service', '<section class="service-two">'),
    ('faq', '<section class="faq-one">'),
    ('skill', '<section class="skill-one">'),
    ('project', '<section class="project-one">'),
    ('testimonials', '<section class="testimonials-one">'),
    ('timeline', '<section class="cta-four">'),
    ('work_process', '<section class="work-process-one">'),
    ('contact', '<section class="contact-one">'),
    ('contact_info', '<section class="contact-info">'),
    ('blog', '<section class="blog-two">'),
    ('cta', '<section class="cta-two">'),
    ('footer', '<footer class="main-footer background-black">')
]

# Find line indices
indices = {}
indices['start'] = 0

for name, marker in markers:
    if name == 'start': continue
    found = False
    for i, line in enumerate(lines):
        if marker in line:
            indices[name] = i
            found = True
            break
    if not found:
        print(f"Error: Could not find marker for {name}: {marker}")
        exit(1)

# Sort markers by index to ensure strictly correct slicing (though list order should match)
sorted_markers = sorted(indices.items(), key=lambda x: x[1])

chunks = {}
for i in range(len(sorted_markers)):
    name, start_idx = sorted_markers[i]
    if i < len(sorted_markers) - 1:
        end_idx = sorted_markers[i+1][1]
        chunks[name] = lines[start_idx:end_idx]
    else:
        # Last chunk goes to end of file
        chunks[name] = lines[start_idx:]

# Define NEW order
new_order = [
    'start',
    'feature',
    'about',
    'service',
    'project',
    'work_process',
    'skill',
    'timeline',
    'faq',
    'blog',
    'clients',
    'testimonials',
    'contact',
    'contact_info',
    'cta',
    'footer'
]

# Reassemble
new_content_lines = []
for name in new_order:
    print(f"Adding {name}...")
    new_content_lines.extend(chunks[name])

# Write back
with open(file_path, 'w', encoding='utf-8') as f:
    f.writelines(new_content_lines)

print("Successfully reordered sections.")
