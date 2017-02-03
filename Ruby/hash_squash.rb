# flatten a nested hash by prefixing parent keys to child keys.
# delimiter and default prefix can be specified
class Hash
  def squash del='_', prefix=''
    new = {}
    self.each do |k, v|
      if v.respond_to? :keys 
        new.merge! v.squash(del, "#{prefix}#{k}#{del}")
      else
        new["#{prefix}#{k}".to_sym] = v
      end
    end
    return new
  end
end

