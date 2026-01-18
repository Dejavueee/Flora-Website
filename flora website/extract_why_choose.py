import re

with open("soilux_reference.html", "r", encoding="utf-8") as f:
    content = f.read()

# Pattern: <!-- Why Choose Us Section Start --> ... <!-- Why Choose Us Section End -->
# Note: Ensure the pattern matches the exact comments or use flexible regex
# In Soilux it usually is class="why-choose-us" or similar.
# Step 423 showed lines 660: <!-- Why Choose Us Section End -->
# Step 409 showed snippet: 
# <div class="why-choose-us-box tab-content wow fadeInUp" ...>
# It seems the section is separate.
# I will look for the wrapper commonly found.

match = re.search(r'(<!-- Why Choose Us Section Start -->.*?<!-- Why Choose Us Section End -->)', content, re.DOTALL)
if match:
    section_html = match.group(1)
    
    # Save to file
    with open("why_choose_us_snippet.html", "w", encoding="utf-8") as f_out:
        f_out.write(section_html)
    print("Extracted Why Choose Us section.")
else:
    print("Could not find exact comments. Searching for class 'why-choose-us'...")
    match_class = re.search(r'(<div class="[^"]*why-choose-us[^"]*">.*?</div>\s*</div>)', content, re.DOTALL) # Very rough
    if match_class:
        print("Found by class (rough match).")
        with open("why_choose_us_snippet.html", "w", encoding="utf-8") as f_out:
            f_out.write(match_class.group(1))
    else:
        print("Failed to extract.")
        # Debug: print keys
        print(content[:500])
