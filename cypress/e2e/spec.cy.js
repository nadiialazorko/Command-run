describe("template spec", () => {
  it("passes", () => {
    cy.visit("https://example.cypress.io");

    cy.readFile(".dev/self-signed.key").then((key) => {
      cy.log(key);
    });

    cy.readFile(".dev/self-signed.crt").then((crt) => {
      cy.log(crt);
    });
  });
});
