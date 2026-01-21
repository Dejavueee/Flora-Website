import os
import re

def update_file(filepath):
    try:
        with open(filepath, 'r', encoding='utf-8') as f:
            content = f.read()
    except Exception as e:
        print(f"Skipping {filepath}: {e}")
        return

    # Define the new contact block
    new_contact = """<ul class="mobile-nav__contact list-unstyled">
                <li>
                    <i class="fa fa-envelope"></i>
                    <a href="mailto:info@flora.co.zw">info@flora.co.zw</a>
                </li>
                <li>
                    <i class="fas fa-solar-panel"></i>
                    <a href="tel:+263715616149">Solar: +263 71 561 6149</a>
                </li>
                <li>
                    <i class="fas fa-burn"></i>
                    <a href="tel:+263714704424">Gas: +263 71 470 4424</a>
                </li>
            </ul><!-- /.mobile-nav__contact -->"""

    # Define the new social block
    # Using FB and IG for both divisions as they are key social platforms for mobile
    new_social = """<div class="mobile-nav__social">
                <a href="https://www.facebook.com/profile.php?id=61582152146037" title="Flora Solar Facebook" target="_blank">
                    <i class="fab fa-facebook-f" aria-hidden="true"></i>
                    <span class="sr-only">Flora Solar Facebook</span>
                </a>
                <a href="https://www.instagram.com/florasolarandtech/" title="Flora Solar Instagram" target="_blank">
                    <i class="fab fa-instagram" aria-hidden="true"></i>
                    <span class="sr-only">Flora Solar Instagram</span>
                </a>
                <a href="https://www.facebook.com/profile.php?id=61583505607155" title="Flora Gas Facebook" target="_blank">
                    <i class="fab fa-facebook-f" aria-hidden="true"></i>
                    <span class="sr-only">Flora Gas Facebook</span>
                </a>
                <a href="https://www.instagram.com/floragaszw/" title="Flora Gas Instagram" target="_blank">
                    <i class="fab fa-instagram" aria-hidden="true"></i>
                    <span class="sr-only">Flora Gas Instagram</span>
                </a>
            </div><!-- /.mobile-nav__social -->"""

    # Regex to find the contact block
    # Matches <ul ...> ... </ul><!-- /.mobile-nav__contact -->
    contact_pattern = re.compile(r'<ul class="mobile-nav__contact list-unstyled">.*?</ul><!-- /.mobile-nav__contact -->', re.DOTALL)
    
    # Regex to find the social block
    # Matches <div ...> ... </div><!-- /.mobile-nav__social -->
    social_pattern = re.compile(r'<div class="mobile-nav__social">.*?</div><!-- /.mobile-nav__social -->', re.DOTALL)

    new_content = contact_pattern.sub(new_contact, content)
    new_content = social_pattern.sub(new_social, new_content)

    if new_content != content:
        with open(filepath, 'w', encoding='utf-8') as f:
            f.write(new_content)
        print(f"Updated {filepath}")
    else:
        print(f"No changes needed (or pattern not found) for {filepath}")

def main():
    directory = "."
    print(f"Scanning directory: {os.path.abspath(directory)}")
    for filename in os.listdir(directory):
        if filename.endswith(".html"):
            filepath = os.path.join(directory, filename)
            update_file(filepath)

if __name__ == "__main__":
    main()
