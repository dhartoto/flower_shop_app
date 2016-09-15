models = File.expand_path("../../models", __FILE__)
spec_models = File.expand_path("../models", __FILE__)
spec_lib = File.expand_path("../lib", __FILE__)
$:.unshift(models, spec_models, spec_lib)

# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
end
