
import os

target_dir = r"c:\Users\Lenovo\Desktop\flora website\alefox-clone-index-2"

target_block = """                        <li class="dropdown">
                            <a href="#">Blog</a>
                            <ul>
                                <li><a href="blog-details.html">Maximizing Solar Efficiency</a></li>
                                <li><a href="blog-details.html">LPG Usage & Safety</a></li>
                                <li><a href="blog-details.html">Efficient Cooking Tips</a></li>
                            </ul>
                        </li>"""

replacement_block = """                        <li class="dropdown">
                            <a href="blog.html">Blog</a>
                            <ul>
                                <li><a href="blog-details-solar-efficiency.html">Maximizing Solar Efficiency</a></li>
                                <li><a href="blog-details-gas-safety.html">LPG Usage & Safety</a></li>
                                <li><a href="blog-details-cooking-tips.html">Efficient Cooking Tips</a></li>
                            </ul>
                        </li>"""

count = 0
for filename in os.listdir(target_dir):
    if filename.endswith(".html"):
        filepath = os.path.join(target_dir, filename)
        try:
            with open(filepath, "r", encoding="utf-8") as f:
                content = f.read()
            
            if target_block in content:
                new_content = content.replace(target_block, replacement_block)
                with open(filepath, "w", encoding="utf-8") as f:
                    f.write(new_content)
                print(f"Updated: {filename}")
                count += 1
            else:
                print(f"Skipped (not found): {filename}")
        except Exception as e:
            print(f"Error processing {filename}: {e}")

print(f"Total files updated: {count}")
