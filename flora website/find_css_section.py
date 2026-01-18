
import re

css_file = r"c:\Users\Lenovo\Desktop\flora website\alefox-clone-index-2\assets\css\soilux-custom.css"

with open(css_file, "r") as f:
    content = f.read()

# Pattern to find .our-approach or .approach blocks
pattern = r"(\.(our-approach|approach-item)[^{]*\{[^}]*\})"

matches = re.finditer(pattern, content, re.DOTALL)

print("Found CSS blocks:")
for match in matches:
    print(match.group(1))
    print("-" * 20)
