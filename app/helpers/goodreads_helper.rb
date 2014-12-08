module GoodreadsHelper

  def goodreads_search(query)
  	search = $gr_client.search_books(query)
  	search.results.work
  end

end