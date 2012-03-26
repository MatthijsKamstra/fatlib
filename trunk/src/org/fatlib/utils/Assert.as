package org.fatlib.utils
{
	import flash.utils.getQualifiedClassName;

	public class Assert
		{
			/**
			 * Ensures that an object reference passed as a paramater to the calling method is not null.
			 */
			public static function notNull(reference : Object, errorMessage : String = null) : *
			{
				// Special case for handling XMLList objects (used when validating XML).
				if (reference == null || (reference is XMLList && (reference as XMLList) == undefined))
				{
					throw new ArgumentError(errorMessage);
				}
				return reference;
			}
			
			
			/**
			 * Ensures that an object reference passed as a paramater to the calling method is not null.
			 */
			public static function isNull(reference : Object, errorMessage : String = null) : *
			{
				// Special case for handling XMLList objects (used when validating XML).
				if (!(reference == null || (reference is XMLList && (reference as XMLList) == undefined)))
				{
					throw new ArgumentError(errorMessage);
				}
				return reference;
			}

			/**
			 * Ensures that a String reference passed as a paramater to the calling method is not empty.
			 */
			public static function stringNotEmpty(string : String, errorMessage : String = null) : *
			{
				// Special case for handling XMLList objects (used when validating XML).
				if (string == null || string == "")
				{
					throw new ArgumentError(errorMessage);
				}
				return string;
			}

			 /**
			 * Ensures that the supplied value falls within the supplied Range.  If this precondition is not met, an
			 * ArgumentError is thrown.
			 */
			public static function isGreaterThan(value : Number, minValue : Number, errorMessage : String = null) : *
			{
				if (value <= minValue)
				{
					errorMessage ||= "supplied value " + value + " is less than or equal to " + minValue;
					throw new ArgumentError(errorMessage);
				}
				return value;
			}

			/**
			 * Convenience method, ensures value evaluates to true or throws error
			 */
			public static function isTrue(value : Boolean, errorMessage : String = null) : *
			{
				if (!value)
				{
					errorMessage ||= "supplied value is false" + value;
					throw new ArgumentError(errorMessage);
				}
				return value;
			}

			/**
			 * Convenience method, ensures value evaluates to true or throws error
			 */
			public static function isFalse(value : Boolean, errorMessage : String = null) : *
			{
				if (value)
				{
					errorMessage ||= "supplied value is false" + value;
					throw new ArgumentError(errorMessage);
				}
				return value;
			}

			/**
			 * Ensures that an object reference passed is an instance of the supplied Type
			 */
			public static function isType(reference : Object, type : Class, errorMessage : String = null) : *
			{
				Assert.notNull(reference);

				if (!(reference is type))
				{
					if (errorMessage == null)
					{
						errorMessage = "Supplied object reference is not of type " + getQualifiedClassName(type) + ", is: " + getQualifiedClassName(reference);
					}
					throw new ArgumentError(errorMessage);
				}

				return reference;
			}
	}
}
