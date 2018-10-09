# SQL Server BinaryClock

Binary Clock in SQL Server

Fun experiment after attempting this in C# code as an application.

 The SP (Stored Procedure) can be run with the following variables:

EXECUTE [dbo].[BinaryClockSQL] @symbolList = 1 --Shows list of available symbols pre inserted

EXECUTE [dbo].[BinaryClockSQL] @binaryCalc = 0 -- Shows Binary Bit Values in Decimal value representation

EXECUTE [dbo].[BinaryClockSQL] @binaryCalc = 1 -- Shows Clock with default Unicode char

to switch unicode char to display run:

EXECUTE [dbo].[BinaryClockSQL] @unicodeCharStyle = 1 -- Replace the int value with required value

Still WIP - additions to be done
Help - create help section for the SP
Pivot - ability to Pivot the columns which displays Binary values
UnicodeChar - Add larger collection of unicode characters