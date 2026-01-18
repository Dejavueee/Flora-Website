
import os
import re

# The new header content (Active removed from Home)
NEW_HEADER = """        <header class="main-header main-header--three sticky-header sticky-header--normal">
            <div class="main-header__inner">
                <div class="main-header__logo">
                    <a href="index.html">
                        <img src="assets/images/logo-dark.png" alt="Alefox HTML" width="147">
                    </a>
                </div><!-- /.main-header__logo -->
                <nav class="main-header__nav main-menu">
                    <ul class="main-menu__list">
                        <li>
                            <a href="index.html">Home</a>
                        </li>
                        <li>
                            <a href="about.html">About Us</a>
                        </li>
                        <li>
                            <a href="services.html">Services</a>
                        </li>
                        <li class="dropdown">
                            <a href="project.html">Projects</a>
                            <ul>
                                <li><a href="project.html#solar">Flora Solar & Tech</a></li>
                                <li><a href="project.html#gas">Flora Gas</a></li>
                            </ul>
                        </li>
                        <li class="dropdown">
                            <a href="#">Shop</a>
                            <ul>
                                <li><a href="products.html?category=solar">Solar Products</a></li>
                                <li><a href="products.html?category=gas">Gas Products</a></li>
                                <li><a href="products.html?category=all">All Products</a></li>
                            </ul>
                        </li>
                        <li>
                            <a href="blog.html">Blog</a>
                        </li>
                        <li>
                            <a href="contact.html">Contact</a>
                        </li>
                    </ul>
                </nav><!-- /.main-header__nav -->
                <div class="main-header__right">
                    <div class="mobile-nav__btn mobile-nav__toggler">
                        <span></span>
                        <span></span>
                        <span></span>
                    </div><!-- /.mobile-nav__toggler -->
                    <a href="#" class="search-toggler main-header__search">
                        <i class="icon-magnifying-glass" aria-hidden="true"></i>
                        <span class="sr-only">Search</span>
                    </a><!-- /.search-toggler -->
                    <a href="cart.html" class="main-header__cart">
                        <i class="icon-shopping-cart" aria-hidden="true"></i>
                        <span class="main-header__cart__count">02</span>
                        <span class="sr-only">Search</span>
                    </a><!-- /.search-toggler -->
                </div><!-- /.main-header__right -->
            </div><!-- /.main-header__inner -->
        </header><!-- /.main-header -->"""

TARGET_FILES = [
    "products.html",
    "products-gas.html",
    "products-solar.html",
    "about.html",
    "services.html",
    "project.html",
    "blog.html",
    "contact.html"
]

def update_file(filepath):
    if not os.path.exists(filepath):
        print(f"Skipping {filepath} (Not found)")
        return

    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()

    # Regex to find the header block
    # Looks for <header class="main-header ... </header><!-- /.main-header -->
    # We use dotall to capture newlines
    pattern = re.compile(r'<header class="main-header.*?</header><!-- /.main-header -->', re.DOTALL)
    
    if pattern.search(content):
        new_content = pattern.sub(NEW_HEADER, content)
        with open(filepath, 'w', encoding='utf-8') as f:
            f.write(new_content)
        print(f"Updated {filepath}")
    else:
        print(f"Header pattern not found in {filepath}")

if __name__ == "__main__":
    base_dir = os.getcwd()
    for filename in TARGET_FILES:
        filepath = os.path.join(base_dir, filename)
        update_file(filepath)
