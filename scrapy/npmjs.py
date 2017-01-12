import scrapy



class BlogSpider(scrapy.Spider):
    name = 'npmspider'
    #start_urls = ['https://rubygems.org/stats?page=1']
    #start_urls = ['https://www.npmjs.com/browse/star?offset=%s' % page for page in xrange(0,36000,36)]
    start_urls = ['https://www.npmjs.com/browse/star?offset=%s' % page for page in xrange(0,50000,36)]


    def parse(self, response):
        for package in response.css("a.name::text"):
            print package.extract()
            #yield {'gem': gem.extract_first()}


        #next_page = response.css('div.prev-post > a ::attr(href)').extract_first()
        #if next_page:
        #    yield scrapy.Request(response.urljoin(next_page), callback=self.parse)
