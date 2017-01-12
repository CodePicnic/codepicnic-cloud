import scrapy



class BlogSpider(scrapy.Spider):
    name = 'blogspider'
    #start_urls = ['https://rubygems.org/stats?page=1']
    start_urls = ['http://rubygems.org/stats?page=%s' % page for page in xrange(1,1245)]


    def parse(self, response):
        for gem in response.css("h3.stats__graph__gem__name a::text"):
            print gem.extract()
            #yield {'gem': gem.extract_first()}


        #next_page = response.css('div.prev-post > a ::attr(href)').extract_first()
        #if next_page:
        #    yield scrapy.Request(response.urljoin(next_page), callback=self.parse)
