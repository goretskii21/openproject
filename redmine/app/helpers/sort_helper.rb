module SortHelper
  def sort_init(default_key, default_order='asc', name=nil)
    @sort_name = name || @params[:controller] + @params[:action] + '_sort'
    @sort_default = {:key => default_key, :order => default_order}
  end
  def sort_update()
    if @params[:sort_key]
      sort = {:key => @params[:sort_key], :order => @params[:sort_order]}
    elsif @session[@sort_name]
      sort = @session[@sort_name]   # Previous sort.
    else
      sort = @sort_default
    end
    @session[@sort_name] = sort
  end
  def sort_clause()
    @session[@sort_name][:key] + ' ' + @session[@sort_name][:order]
  end
  def sort_link(column, caption=nil)
    key, order = @session[@sort_name][:key], @session[@sort_name][:order]
    if key == column
      if order.downcase == 'asc'
        icon = 'sort_asc'
        order = 'desc'
      else
        icon = 'sort_desc'
        order = 'asc'
      end
    else
      icon = nil
      order = 'desc' # changed for desc order by default
    end
    caption = titleize(Inflector::humanize(column)) unless caption
    params = {:params => {:sort_key => column, :sort_order => order}}
    link_to(caption, params) + (icon ? nbsp(2) + image_tag(icon) : '')
  end
  def sort_header_tag(column, options = {})
    if options[:caption]
      caption = options[:caption]
      options.delete(:caption)
    else
      caption = titleize(Inflector::humanize(column))
    end
    options[:title]= "Sort by #{caption}" unless options[:title]
    content_tag('th', sort_link(column, caption), options)
  end
  private
    def nbsp(n)
      '&nbsp;' * n
    end
    def titleize(title)
      title.split.map {|w| w.capitalize }.join(' ')
    end
end
