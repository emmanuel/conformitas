Stealing Django form objects for use in Ruby web frameworks
===========================================================

This will become a Ruby implementation of the concepts embodied in [Django's
form objects](https://docs.djangoproject.com/en/dev/topics/forms/#form-objects).
It is also an alternative to Rails' ActiveModel, with several advantages.

This is a play in 3 acts.


Act 1: Form objects (free-standing)
-----------------------------------

Using [Virtus](https://github.com/solnic/virtus) and
[Aequitas](https://github.com/emmanuel/aequitas),
define objects that support a given form, with typed attributes and validations
appropriate to the given input use-case.

Form objects may be used to back a form that triggers work not directly related
to any particular persistent model or to create or update several persistent
resources.

These form objects correspond with the
[Django concept of the same name](https://docs.djangoproject.com/en/dev/topics/forms/#form-objects).


Act 2: Model form objects (defined by ORM model reflection)
-----------------------------------------------------------

Any ORM can be supported by defining an adapter that reflects on a
persistent model and generates a form object.

The generated form object can be configured to:

1. accept a specified subset of the persistent model's total fields
  (subsumes `attr_accessible` functionality).

1. validate according to the model or differently
  (subsumes many uses of contextual validations)

1. build nested/dependent objects from a single form.

  TODO: How to support related objects remains to be defined.
    This should eventually encompass both 'Embedded Value' and
    `accepts_nested_attributes` use-cases

1. serve as a home for business logic around a given data interaction
  (eg., Forms::UserSignup, which could create a User and send a welcome message)


Act 3: Form builders for producing different kinds of forms
-----------------------------------------------------------

Form builders will be initialized with a form object and will reflect on the
attributes defined for it. Each form object has a 1-to-1 mapping with a given
form (input use-case), so the form builder can be a simple implementation of
the Builder pattern.

The first form builder will produce minimal but valid HTML4 form markup.
A future HTML5 form builders will emit markup using HTML5 date/time/number/url,
etc elements (with min/max/step/pattern attributes), and could also include data
attributes to configure (arbitrarily complex) client-side validation logic.


Credits
-------

Thanks to Django for the useful abstraction to steal.

Inspired by a remark from [Yehuda Katz's presentation at GoGaRuCo 2011](http://confreaks.net/videos/651-gogaruco2011-keynote-on-building-frameworks).
