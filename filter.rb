class Pattern
  attr_accessor :list, :first, :full
  def initalize(text)
    @first = text[0]
    @full = text
    @list = text.split("")
    @list.delete_at(0)
  end
end

