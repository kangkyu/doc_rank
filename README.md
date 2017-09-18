# DocRank

Returns a similarity score between one or many documents against a base document (keyword comparison).

[![Build Status](http://img.shields.io/travis/S1v4/doc_rank/master.svg)](https://travis-ci.org/S1v4/doc_rank)
[![Code Climate](http://img.shields.io/codeclimate/github/S1v4/doc_rank.svg)](https://codeclimate.com/github/S1v4/doc_rank)
[![Online docs](http://img.shields.io/badge/docs-✓-green.svg)](http://www.rubydoc.info/gems/doc_rank/frames)
[![Gem Version](http://img.shields.io/gem/v/doc_rank.svg)](http://rubygems.org/gems/doc_rank)

The **source code** is available on [GitHub](https://github.com/S1v4/doc_rank) and the **documentation** on [RubyDoc](http://www.rubydoc.info/gems/doc_rank/frames).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'doc_rank'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install doc_rank

## Usage

DocRank requires you to create a 'Ranker object that will consist of your base document and an array of other documents. The features of Ranker will then provide you a comparison value of how well your target documents match with your base document.'

```ruby
require 'doc_rank'
```

DocRank::Ranker#scores
--------------

`scores` will return the number of matches between the keywords of the base document and any target documents.

```ruby
base_document = 'path-to-base-doc'
target_document = 'path-to-doc1'

ranker = DocRank::Ranker.new base_document, target_document
ranker.scores
# => {'target_doc_name.pdf' => 50}
# There are 50 words in the target document that were also in the base document
```

You can also pass multiple targets.

```ruby
base_document = 'path-to-base-doc'
target_documents = ['path-to-doc1', 'path-to-doc2', 'path-to-doc3']

ranker = DocRank::Ranker.new base_document, target_documents
ranker.scores
# => {'target_doc1.pdf' => 50, 'target_doc2.docx' => 30, 'target_doc3.txt' => 15}
# Document scores are sorted in descending order
```

DocRank::Ranker#weighted_scores
--------------

`weighted_scores` accounts for repetitions of each keyword unlike `scores` where the number of occurences is disregarded.
Keywords that occur more in a document will have a higher weight versus those that do not. If a word exists in both the base document
and the target document, the two weights are added:

```ruby
base_words = "hello hello world world from above"
weights = {"hello" => 9, "world" => 6, "from" => 3, "above" => 3}

target_words = "hello world"
weights = {"hello" => 3, "world" => 3}

target_score = 21 # (9 + 3) + (6 + 3)
# The total score for a target document will be the sum of all the matches.
```

Use `weighted_scores` just like `scores`:

```ruby
base_document = 'path-to-base-doc'
target_document = 'path-to-doc1'

ranker = DocRank::Ranker.new base_document, target_document
ranker.weighted_scores
# => {'target_doc_name.pdf' => 120}
```

You can also pass multiple targets.

```ruby
base_document = 'path-to-base-doc'
target_documents = ['path-to-doc1', 'path-to-doc2', 'path-to-doc3']

ranker = DocRank::Ranker.new base_document, target_documents
ranker.weighted_scores
# => {'target_doc1.pdf' => 180, 'target_doc2.docx' => 145, 'target_doc3.txt' => 90}
# Document scores are sorted in descending order
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/S1v4/doc_rank.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

Thanks :tada:
