import scrapy



class BlogSpider(scrapy.Spider):
    name = 'blogspider'
    start_urls = ['https://packagist.org/explore/popular?page=%s' % page for page in xrange(1,300)]


    def parse(self, response):
        for gem in response.css("h4.font-bold a::text"):
            print gem.extract()
            #yield {'gem': gem.extract_first()}


        #next_page = response.css('div.prev-post > a ::attr(href)').extract_first()
        #if next_page:
        #    yield scrapy.Request(response.urljoin(next_page), callback=self.parse)
