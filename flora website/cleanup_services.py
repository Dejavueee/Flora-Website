
import os
import re

files_to_update = [
    "service-details.html",
    "service-commercial.html",
    "service-equipment.html",
    "service-gas-refill.html",
    "service-bulk-gas.html",
    "service-cylinders.html",
    "service-maintenance.html",
    "service-delivery.html"
]

# The widget block to remove (exact string from service-bulk-gas.html inspection)
widget_block = """                            <!-- Download Brochure Widget -->
                            <div class="service-details__download wow fadeInUp" data-wow-delay="0.3s">
                                <div class="service-details__download-icon">
                                    <i class="fas fa-file-pdf"></i>
                                </div>
                                <h3 class="service-details__download-title">Company Profile</h3>
                                <p class="service-details__download-text">Download our latest company brochure to learn more about our services.</p>
                                <a href="assets/downloads/flora-profile.pdf" class="service-details__download-btn" download>Download PDF <i class="fas fa-download ms-2"></i></a>
                            </div>"""

base_dir = "c:/Users/Lenovo/Desktop/flora website/alefox-clone-index-2"

for fname in files_to_update:
    fpath = os.path.join(base_dir, fname)
    if not os.path.exists(fpath):
        print(f"Skipping {fname} (not found)")
        continue
    
    with open(fpath, 'r', encoding='utf-8') as f:
        content = f.read()
    
    original_len = len(content)
    
    # 1. Remove the widget block
    # We try to match flexibility with whitespace
    # But since it was likely pasted, it matches exactly.
    if widget_block in content:
        content = content.replace(widget_block, "")
        print(f"Removed widget from {fname}")
    else:
        # Fallback: Try normalize whitespace if exact match fails
        # But for now, let's just report if it fails
        print(f"Widget not found in {fname} (might be slightly different formatting)")
        
        # Alternative: Try regex for the widget
        # ...
        
    # 2. Fix the extra div
    # Look for 3 closing divs followed by col-xl-8
    # We want to reduce it to 2 closing divs
    
    # Regex for: </div> [whitespace] </div> [whitespace] </div> [whitespace] <div class="col-xl-8
    pattern = r'(</div>\s*</div>)\s*</div>(\s*<div class="col-xl-8)'
    match = re.search(pattern, content)
    if match:
        content = re.sub(pattern, r'\1\2', content)
        print(f"Fixed extra div in {fname}")
    else:
        print(f"No extra div pattern found in {fname}")

    if len(content) != original_len:
        with open(fpath, 'w', encoding='utf-8') as f:
            f.write(content)
        print(f"Saved {fname}")
    else:
        print(f"No changes for {fname}")

