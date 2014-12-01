# CS 270 - Fall 2014 - QR Code Scavenger Hunt - Phase 1

In this phase, we'll create the Event and Location resources.  In doing
so, we'll need to figure out how to wire together these two resources in a
logical manner to reflect the dependencies we've specified for the
project.

A new Rails app has already been created.  To get started, simply clone
the respository into your system.

As a side note, the `rqrcode` gem has already been included into the
Gemfile.  To complete this phase, then, you should simply need to do the
following:

## Event resource

An Event will consist of the following attributes:

- name (as a string)

It will also have a `has_many` association with the Location resource.
Thus, we can generate this resource with a scaffolding command:

`rails g scaffold Event name:string`

Remember, we need to edit the Event model file to include the association:

`has_many :locations`

## Location resource

A Location will consist of the following attributes:

- name (as a string)
- tag (as a randomly generated string of 8 alphanumeric characters)

It will also have a `belongs_to` association with the Event resource.
This assocation will automatically create an additional `event_id`
attribute as well.  We can generate this resource with a scaffolding
command:

`rails g scaffold Location name:string tag:string event:references`

Remember, we need to edit the Location model file to include the association:

`belongs_to :event`

## Seeding the database

We can initialize the database with some test data to get started.  We'll
edit the `config/seeds.rb` file to generate 2 events and 3 locations for
each event:

```
2.times do |i|
  Event.create(name: "Event #{i + 1}"
  3.times do |j|
    if Location.any?
      id = Location.last.id
    else
      id = 0
    end
    Location.create(
      name: "Location #{id + 1} belongs to Event #{i + 1}",
      tag: (('A'..'Z').to_a + ('a'..'z').to_a + (0..9).to_a).shuffle[0..7].join,
      event_id: i + 1
    )
  end
end
```
After creating our seed file, we can initialize the database with:

`rake db:seed`

and at anytime we "mess up" our data, we can reset it with:

`rake db:reset`

## Modifying the views

We want the following behaviour when we run our app:

- When we list an event, we want a list of locations displayed as well
- When we edit an event, we want to add, delete, or edit locations as well
- When we create a new location, we want to automatically assign it to the
  event from which we created the location

In order to do this, we'll need to modify the `_form.html.erb` and
`edit.html.erb` views for the Event resource, as well as the
`_form.html.erb` view for the Location resource.
