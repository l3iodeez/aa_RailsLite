require 'byebug'

def parse_www_encoded_form(www_encoded_form)
  result = {}

  pairs = www_encoded_form.split("&")
    pairs.each do |pair|
      duplet = pair.split("=")
      keys = parse_key(duplet[0])
      result[keys[0]] ||= {}
      current_level = result
      result[keys[0]] = duplet[1] if keys.count == 1
      keys[0..-1].each do |key|
        current_level[key] ||= {}
        if key == keys.last
          current_level[key] = duplet[1]
        else
        current_level = current_level[key]
        end
      end
    end
  result
end

# this should return an array
# user[address][street] should return ['user', 'address', 'street']
def parse_key(key)
  key.split(/\]\[|\[|\]/)
end
