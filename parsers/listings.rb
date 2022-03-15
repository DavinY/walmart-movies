nokogiri = Nokogiri.HTML(content)

products = nokogiri.css(".flex.flex-wrap .mb1.ph1 a")

products.each do |product|
    url = URI.join('https://www.walmart.com', product['href']).to_s
    if url
        pages <<{
            url: url,
            page_type: 'products',
            method: "GET",
            vars:{
                category: page['vars']['category'],
            }
        }
    end
end

pagination_links = nokogiri.css('[aria-label="pagination"] ul li a')
pagination_links.each do |link|
    url = URI.join('https://www.walmart.com', link['href']).to_s
    if url
        pages << {
            url: url,
            page_type: 'listings',
            fetch_type: 'browser',
            vars:{
                category: page['vars']['category']
            }
        }
    end
end