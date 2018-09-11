# Amce.Financial

This is a sample solution for extending and wrapping a [Quandis Business Objects](https://www.quandis.com/platform) installation.

It comprises:

- **client.Acme.Financial**: sample C# and JS code to communication with QBO.
- **server.Amce.Financial**: a web project deployed to a QBO server farm that extends QBO.
  - **server.Acme.Financial.Tests**: unit tests for server.Acme.Financial

## Server components

### HelloWorld.cs

HelloWorld.cs is an IService plugin that returns a "Hello World" message.

### Dropbox.cs

Dropbox.cs is an IFileObject plugin that allows QBO's document management suite to read and write files from Dropbox.

### AlphaVantage.cs

AlphaVantage is an IService plugin that retrieve stock market data for a stock market symbol.

