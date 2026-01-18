
import re

css_path = r'c:\Users\Lenovo\Desktop\flora website\alefox-clone-index-2\assets\css\alefox.css'
sections = [
    'feature-one', 'about-two', 'service-two', 'project-one', 
    'work-process-one', 'skill-one', 'cta-four', 'testimonials-one', 
    'faq-one', 'blog-two', 'client-carousel', 'contact-one', 
    'contact-info', 'cta-two'
]

with open(css_path, 'r', encoding='utf-8') as f:
    content = f.read()

print(f"File length: {len(content)} characters")

for section in sections:
    # Regex to find class definition and content inside brackets
    # Matches .classname { ... }
    # non-greedy match for content
    pattern = r'\.' + section + r'\s*{([^}]*)}'
    matches = re.finditer(pattern, content)
    
    found = False
    for match in matches:
        found = True
        block = match.group(1)
        # Look for padding
        padding = re.search(r'padding:\s*([^;]+);', block)
        pad_val = padding.group(1) if padding else "No padding property"
        print(f"{section}: {pad_val}")
        
    if not found:
        print(f"{section}: Not found")
