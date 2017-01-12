import scrapy



class BlogSpider(scrapy.Spider):
    name = 'blogspider'
    start_urls = ['http://pypi-ranking.info/alltime?page=%s' % page for page in xrange(1,200)]


    def parse(self, response):
        for gem in response.css("span.list_title::text"):
            print gem.extract()
            #yield {'gem': gem.extract_first()}


        #next_page = response.css('div.prev-post > a ::attr(href)').extract_first()
        #if next_page:
        #    yield scrapy.Request(response.urljoin(next_page), callback=self.parse)
