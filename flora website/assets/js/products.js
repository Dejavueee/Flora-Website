$(document).ready(function () {
    // Product Data
    // Images are reused from existing assets for now to ensure they work.
    const allProducts = [
        // GAS PRODUCTS (Need at least 2 pages -> 9+ items, e.g. 15 items)
        { id: 1, category: 'gas', name: '9kg Gas Cylinder', price: '$45.00', image: 'assets/images/products/gas-cylinder-9kg.png' },
        { id: 2, category: 'gas', name: '19kg Gas Cylinder', price: '$85.00', image: 'assets/images/products/gas-cylinder-19kg.png' },
        { id: 3, category: 'gas', name: '48kg Gas Cylinder', price: '$180.00', image: 'assets/images/products/gas-cylinder-48kg.png' },
        { id: 4, category: 'gas', name: 'Gas Stove 2-Plate', price: '$35.00', image: 'assets/images/products/gas-stove-2-plate.png' },
        { id: 5, category: 'gas', name: 'Gas Stove 4-Plate', price: '$120.00', image: 'assets/images/products/gas-stove-4-plate.png' },
        { id: 6, category: 'gas', name: 'Mobile Gas Heater', price: '$95.00', image: 'assets/images/products/mobile-gas-heater.png' },
        { id: 7, category: 'gas', name: 'Gas Regulator', price: '$15.00', image: 'assets/images/products/gas-regulator.png' },
        { id: 8, category: 'gas', name: 'Hose Pipe (per meter)', price: '$5.00', image: 'assets/images/products/hose-pipe.png' },
        { id: 9, category: 'gas', name: 'Gas Geyser 12L', price: '$220.00', image: 'assets/images/products/gas-geyser-12l.png' },
        { id: 10, category: 'gas', name: 'Gas Geyser 16L', price: '$280.00', image: 'assets/images/products/gas-geyser-16l.png' },
        { id: 11, category: 'gas', name: 'Camping Gas Bottle', price: '$25.00', image: 'assets/images/products/camping-gas-bottle.png' },
        { id: 12, category: 'gas', name: 'Gas Burner Ring', price: '$30.00', image: 'assets/images/products/gas-burner-ring.png' },
        { id: 13, category: 'gas', name: 'Gas Leak Detector', price: '$40.00', image: 'assets/images/products/gas-leak-detector.png' },
        { id: 14, category: 'gas', name: 'Industrial Valve', price: '$55.00', image: 'assets/images/products/industrial-valve.png' },
        { id: 15, category: 'gas', name: 'Gas Cage', price: '$80.00', image: 'assets/images/products/gas-cage.png' },

        // SOLAR PRODUCTS (Need 3 pages -> 19+ items, e.g. 25 items)
        { id: 101, category: 'solar', name: '375W Solar Panel', price: '$110.00', image: 'assets/images/products/solar-panel-375w.png' },
        { id: 102, category: 'solar', name: '450W Solar Panel', price: '$135.00', image: 'assets/images/products/solar-panel-450w.png' },
        { id: 103, category: 'solar', name: '550W Solar Panel', price: '$160.00', image: 'assets/images/products/solar-panel-550w.png' },
        { id: 104, category: 'solar', name: '3kVA Hybrid Inverter', price: '$450.00', image: 'assets/images/products/solar-inverter-3kva.png' },
        { id: 105, category: 'solar', name: '5kVA Hybrid Inverter', price: '$650.00', image: 'assets/images/products/solar-inverter-5kva.png' },
        { id: 106, category: 'solar', name: '8kVA Hybrid Inverter', price: '$1,200.00', image: 'assets/images/products/solar-inverter-8kva.png' },
        { id: 107, category: 'solar', name: '100Ah Gel Battery', price: '$180.00', image: 'assets/images/products/solar-battery-gel-100ah.png' },
        { id: 108, category: 'solar', name: '200Ah Gel Battery', price: '$320.00', image: 'assets/images/products/solar-battery-gel-200ah.png' },
        { id: 109, category: 'solar', name: 'Lithium Battery 2.4kWh', price: '$600.00', image: 'assets/images/products/solar-battery-lithium-2-4kwh.png' },
        { id: 110, category: 'solar', name: 'Lithium Battery 4.8kWh', price: '$1,100.00', image: 'assets/images/products/solar-battery-lithium-4-8kwh.png' },
        { id: 111, category: 'solar', name: 'Solar Charge Controller', price: '$45.00', image: 'assets/images/products/solar-charge-controller.png' },
        { id: 112, category: 'solar', name: 'MC4 Connectors (Pair)', price: '$5.00', image: 'assets/images/products/solar-mc4-connectors.png' },
        { id: 113, category: 'solar', name: 'Solar Cable 4mm (m)', price: '$1.50', image: 'assets/images/products/solar-cable-4mm.png' },
        { id: 114, category: 'solar', name: 'Solar Cable 6mm (m)', price: '$2.00', image: 'assets/images/products/solar-cable-6mm.png' },
        { id: 115, category: 'solar', name: 'Mounting Rail 3m', price: '$25.00', image: 'assets/images/products/solar-mounting-rail.png' },
        { id: 116, category: 'solar', name: 'Roof Hook (Tile)', price: '$8.00', image: 'assets/images/products/solar-roof-hook-tile.png' },
        { id: 117, category: 'solar', name: 'Roof Hook (IBR)', price: '$6.00', image: 'assets/images/products/solar-roof-hook-ibr.png' },
        { id: 118, category: 'solar', name: 'DC Breaker 63A', price: '$12.00', image: 'assets/images/products/solar-dc-breaker-63a.png' },
        { id: 119, category: 'solar', name: 'Fuse Holder', price: '$10.00', image: 'assets/images/products/solar-fuse-holder.png' },
        { id: 120, category: 'solar', name: 'Surge Protection', price: '$35.00', image: 'assets/images/products/solar-surge-protection.png' },
        { id: 121, category: 'solar', name: 'Combiner Box 2-in-2', price: '$85.00', image: 'assets/images/products/solar-combiner-box.png' },
        { id: 122, category: 'solar', name: 'Solar Flood Light', price: '$40.00', image: 'assets/images/products/solar-flood-light.png' },
        { id: 123, category: 'solar', name: 'Solar Street Light', price: '$75.00', image: 'assets/images/products/solar-street-light.png' },
        { id: 124, category: 'solar', name: 'Solar Water Pump', price: '$250.00', image: 'assets/images/products/solar-water-pump.png' },
        { id: 125, category: 'solar', name: 'Portable Solar Kit', price: '$150.00', image: 'assets/images/products/portable-solar-kit.png' }
    ];

    const itemsPerPage = 9;

    // Helper to get query param
    function getQueryParam(param) {
        const urlParams = new URLSearchParams(window.location.search);
        return urlParams.get(param);
    }

    function renderPage() {
        // Get category and page from URL
        // If window.productCategory is set, use it. Otherwise fall back to query param.
        let category = (typeof window.productCategory !== 'undefined') ? window.productCategory : (getQueryParam('category') || 'all');
        let page = parseInt(getQueryParam('page')) || 1;

        // Current Page Base URL (e.g., products.html, products-gas.html)
        const baseUrl = window.location.pathname.split('/').pop() || 'products.html';

        // Update active menu link
        updateActiveMenu(category);

        // Filter products based on category
        let filteredProducts = allProducts;
        if (category !== 'all') {
            filteredProducts = allProducts.filter(p => p.category === category);
        }

        const totalItems = filteredProducts.length;
        const totalPages = Math.ceil(totalItems / itemsPerPage);

        // Validate page number
        if (page < 1) page = 1;
        if (page > totalPages && totalPages > 0) page = totalPages;

        // Slice data
        const start = (page - 1) * itemsPerPage;
        const end = start + itemsPerPage;
        const pageItems = filteredProducts.slice(start, end);

        // Update Headers - Only if NOT on a specialized page where title is hardcoded.
        // However, updating them dynamically is safer to match sorting/filtering if we add that later.
        // For now, we will update them to ensure consistency.
        const catTitle = category === 'all' ? 'All Products' : (category.charAt(0).toUpperCase() + category.slice(1) + ' Products');
        // Check if we are on the generic page or specific page. 
        // If specific page, title is likely already correct, but updating it doesn't hurt.
        $('#page-title').text(catTitle);
        $('.alefox-breadcrumb li:last-child span').text(catTitle);


        // Update count text
        if (totalItems > 0) {
            $('#result-count').text(`Showing ${start + 1}–${Math.min(end, totalItems)} of ${totalItems} Results`);
        } else {
            $('#result-count').text('No results found');
        }

        // Render Grid
        const $grid = $('#product-grid');
        $grid.empty();

        if (totalItems === 0) {
            $grid.html('<div class="col-12 text-center"><h3>No products found in this category.</h3></div>');
        } else {
            pageItems.forEach((item, index) => {
                // Calculate delay for wow animation
                const delay = (index % 3) * 50;

                const html = `
                    <div class="col-md-6 col-lg-4 col-xl-4">
                        <div class="product__item wow fadeInUp" data-wow-duration='1500ms' data-wow-delay='${delay}ms'>
                            <div class="product__item__img">
                                <img src="${item.image}" alt="${item.name}">
                                <div class="product__item__btn">
                                    <a href="#"><i class="icon-shopping-cart"></i></a>
                                    <a href="#"><i class="far fa-heart"></i></a>
                                    <a href="#"><i class="fas fa-eye"></i></a>
                                </div>
                            </div><!-- /.product-image -->
                            <div class="product__item__content">
                                <div class="product__item__cats">
                                    <a href="${baseUrl}?category=${item.category}">${item.category.charAt(0).toUpperCase() + item.category.slice(1)}</a>
                                </div>
                                <h4 class="product__item__title"><a href="#">${item.name}</a></h4>
                                <div class="product__item__price">${item.price}</div>
                                <div class="product__item__ratings">
                                    <span class="icofont-star"></span><span class="icofont-star"></span><span class="icofont-star"></span><span class="icofont-star"></span><span class="icofont-star"></span>
                                </div>
                            </div>
                        </div>
                    </div>
                `;
                $grid.append(html);
            });
        }

        // Render Pagination
        renderPagination(baseUrl, category, page, totalPages);
    }

    function renderPagination(baseUrl, category, currentPage, totalPages) {
        const $pagination = $('#pagination');
        $pagination.empty();

        if (totalPages <= 1) return;

        // If on a specific page, we don't need ?category=x in the URL if it's implied, 
        // BUT keeping it creates no harm and ensures clarity. 
        // However, if we are on products.html, we MUST have it.
        // We will include it everywhere for simplicity.

        // Prev Arrow
        if (currentPage > 1) {
            $pagination.append(`<li><a href="${baseUrl}?category=${category}&page=${currentPage - 1}"><span class="icofont-double-left"></span></a></li>`);
        }

        for (let i = 1; i <= totalPages; i++) {
            const activeClass = i === currentPage ? 'current' : '';
            $pagination.append(`<li><a class="${activeClass}" href="${baseUrl}?category=${category}&page=${i}">${i}</a></li>`);
        }

        // Next Arrow
        if (currentPage < totalPages) {
            $pagination.append(`<li><a href="${baseUrl}?category=${category}&page=${currentPage + 1}"><span class="icofont-double-right"></span></a></li>`);
        }
    }

    function updateActiveMenu(category) {
        // Reset active classes
        $('.main-menu__list li').removeClass('active current');
        $('.main-menu__list li.dropdown ul li').removeClass('current');

        // Allow some time for alefox.js to do its thing or override it
        const $shopLi = $('.main-menu__list > li.dropdown').filter(function () {
            return $(this).find('a').first().text().trim() === 'Shop';
        });

        $shopLi.addClass('active current');

        // Find submenu item
        // We look for partial matches on href since we might be on products-gas.html
        // And the link is products-gas.html (exact match) OR products.html?category=gas
        const currentPath = window.location.pathname.split('/').pop();

        $shopLi.find('ul li a').each(function () {
            const href = $(this).attr('href');

            // Logic:
            // 1. If href matches current filename exactly (e.g. products-gas.html) -> ACTIVE
            // 2. If current filename is products.html AND href contains category=currentCategory -> ACTIVE

            let isActive = false;

            if (href === currentPath) {
                isActive = true;
            } else if (currentPath === 'products.html' && href.includes(`category=${category}`)) {
                isActive = true;
            }

            if (isActive) {
                $(this).parent().addClass('current');
            }
        });
    }

    // Run
    renderPage();
});
