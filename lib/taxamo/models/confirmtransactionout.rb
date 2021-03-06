# Copyright 2014-2015 Taxamo, Ltd.

# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at [apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0)
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

class ConfirmTransactionOut
  attr_accessor :transaction, :tax_required_fields, :storage_required_fields

  # :internal => :external
  def self.attribute_map
    {
      :transaction => :transaction,
      :tax_required_fields => :tax_required_fields,
      :storage_required_fields => :storage_required_fields

    }
  end

  def initialize(attributes = {})
    return if attributes.empty?
    # Morph attribute keys into undescored rubyish style
    if attributes["transaction"]
      @transaction = Transaction.new(attributes["transaction"])
        
    end
    if attributes["tax_required_fields"]
      if (value = attributes["tax_required_fields"]).is_a?(Array)
          @tax_required_fields = value.map{ |v| TaxRequiredFields.new(v) }
        end
      end
    if attributes["storage_required_fields"]
      if (value = attributes["storage_required_fields"]).is_a?(Array)
          @storage_required_fields = value.map{ |v| StorageRequiredFields.new(v) }
        end
      end
    

  end

  def to_body
    body = {}
    self.class.attribute_map.each_pair do |key, value|
      v = self.send(key)
      unless v.nil?
        if v.is_a?(Array)
          array = Array.new
          v.each do |item|
            if item.respond_to?("to_body".to_sym)
              array.push item.to_body
            else
              array.push item
            end
          end
          body[value] = array
        else
          if v.respond_to?("to_body".to_sym)
            body[value] = v.to_body
          else
            body[value] = v
          end
        end
      end
    end
    body
  end
end

