# Draft
module_function

- marks all following methods as private (сould be accomplished with a call to private)
- makes the methods available as singleton methods on the module
(copy methods to the Conversions module singleton, so it's possible to access the conversion function without including Conversions, simply by calling e.g. Conversions.Point(1,2))