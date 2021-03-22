class SearchController < ApplicationController

  def search
    @tagname = params["tagname"]
    @taged_works = Tag.where('name like ?',"#{@tagname}")

    @total = PostTag.where(tag_id: @taged_works.ids).order("created_at desc")


    # binding.pry
  end

end
