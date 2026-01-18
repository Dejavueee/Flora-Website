
import os
import re

path = r"c:\Users\Lenovo\Desktop\flora website\alefox-clone-index-2\index.html"

def reorder_sections():
    if not os.path.exists(path):
        print(f"File not found: {path}")
        return

    with open(path, 'r', encoding='utf-8') as f:
        content = f.read()

    # Define markers for the main block to be shuffled
    # The block starts after FAQ section, at the Blog CSS definition
    start_marker = '<!-- Custom CSS for Blog Section Overrides -->'
    # The block ends after Testimonials section
    end_marker = '</section><!-- /.testimonials-one -->'

    start_pos = content.find(start_marker)
    end_pos = content.find(end_marker)

    if start_pos == -1 or end_pos == -1:
        print("Could not find start or end markers for the shuffle block.")
        return

    end_pos += len(end_marker)
    
    # Extract the full chunk to rearrange
    full_chunk = content[start_pos:end_pos]
    
    # Now extrat individual components from this chunk using regex or markers
    # 1. Blog (includes style)
    # Starts at start_marker
    # Ends at </section><!-- /.blog-two -->
    blog_end_marker = '</section><!-- /.blog-two -->'
    blog_match = re.search(re.escape(start_marker) + r'.*?' + re.escape(blog_end_marker), full_chunk, re.DOTALL)
    
    if not blog_match:
        print("Could not extract Blog section.")
        return
    blog_section = blog_match.group(0)

    # 2. Offer
    # Starts after Blog
    # <div class="offer-one"> ... </div><!-- /.offer-one -->
    offer_match = re.search(r'<div class="offer-one">.*?</div><!-- /.offer-one -->', full_chunk, re.DOTALL)
    if not offer_match:
        print("Could not extract Offer section.")
        return
    offer_section = offer_match.group(0)

    # 3. Client Carousel
    # <div class="client-carousel ... </div><!-- /.client-carousel -->
    client_match = re.search(r'<div class="client-carousel.*?</div><!-- /.client-carousel -->', full_chunk, re.DOTALL)
    if not client_match:
        print("Could not extract Client section.")
        return
    client_section = client_match.group(0)

    # 4. Testimonials
    # <section class="testimonials-one"> ... </section><!-- /.testimonials-one -->
    testi_match = re.search(r'<section class="testimonials-one">.*?</section><!-- /.testimonials-one -->', full_chunk, re.DOTALL)
    if not testi_match:
        print("Could not extract Testimonials section.")
        return
    testi_section = testi_match.group(0)
    
    print("Extracted all sections successfully.")

    # --- Modify Testimonials Section ---
    # 1. Remove thumbnail UL
    # <ul class="testimonials-one__carousel-thumb ... </ul>
    thum_ul_match = re.search(r'<ul class="testimonials-one__carousel-thumb.*?</ul><!-- Testimonial Thumb -->', testi_section, re.DOTALL)
    if thum_ul_match:
        testi_section = testi_section.replace(thum_ul_match.group(0), "")
        print("Removed testimonial thumbnails.")
    else:
        print("Warning: Could not find testimonial thumbnails to remove.")

    # 2. Update Slick Options
    # data-slick-options='{...}'
    # We want to replace the JSON inside.
    # New options: single slide, fade, autoplay
    new_options = '''{
				"slidesToShow": 1,
				"slidesToScroll": 1,
				"autoplay": true,
				"autoplaySpeed": 5000,
				"speed": 1000,
                "fade": true,
				"dots": false,
				"arrows": false,
                "infinite": true
				}'''
    
    testi_section = re.sub(r'data-slick-options=\'{.*?}\'', f"data-slick-options='{new_options}'", testi_section, flags=re.DOTALL)
    print("Updated testimonial slick options.")

    # --- Reassemble ---
    # Order: Testimonials -> Offer -> Blog -> Client
    
    new_chunk = "\n\n" + testi_section + "\n\n" + offer_section + "\n\n" + blog_section + "\n\n" + client_section
    
    # Replace in original content
    new_content = content[:start_pos] + new_chunk + content[end_pos:]
    
    # Save
    with open(path, 'w', encoding='utf-8') as f:
        f.write(new_content)
    
    print("Successfully reordered sections and saved file.")

if __name__ == "__main__":
    reorder_sections()
