html = Nokogiri.HTML(content)

product = {}

product['title'] = html.at_css('.flex-column h1[itemprop="name"]').text

product['current_price'] = html.at_css('span[itemprop="price"]').text

original_price_elem = html.at_css('[data-testid="add-to-cart-price-atf"] span.strike')

product['original_price'] = original_price_elem ? original_price_elem.text : product['current_price']

rating_elem =  html.at_css('.rating-number')

product['rating'] = rating_elem ? rating_elem.text.strip.gsub(/[()]/, '') : nil

review_elem = html.at_css('[itemprop=ratingCount]')

product['review_count'] = review_elem ? review_elem.text.strip.split(' ').first.to_i : nil

product['walmart_number'] = page['url'].split('/').last.split('?').first

product['image_url'] = html.at_css('.relative img.db')['src']

product['categories'] = html.css('nav[aria-label=breadcrumb] li a span').collect{|span| span.text}

product['url'] = page['url']

product['_collection'] = 'products'

outputs << product