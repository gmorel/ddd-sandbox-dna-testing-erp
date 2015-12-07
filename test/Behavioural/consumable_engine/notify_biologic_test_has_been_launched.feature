# @hint We stick with the Ubiquitous language set in UBIQUITOUS_LANGUAGE_DICTIONARY.md
Feature: Testing Machine notifies a Biologic Test has been launched
    # @hint Implying CONTEXT (if useful)
    Implying consumable has been consumed
    # @hint In order to GOAL
    In order to spend more time focusing on my research rather than on logistic
    # @hint As a ACTOR
    As a Biologist
    # @hint I want to ACTION
    I want to automate consumable deliveries

    Scenario: Successfully notify 1 Supplier to replenish stocks following a Biologic Test with 10 test tube
        # @hint Given steps are in Present Continuous (ing)
        Given the laboratory always needing at least 40ml of "Platinum Blue Supermix" delivered by "Invitrogen"
        And the Testing Machine named "Thermocycler" consuming 22µl of "Platinum Blue Supermix" per test tube
        And the laboratory already having 40220µl of "Platinum Blue Supermix" in stock
        And the Biologic Test "Genotyping Test" being available
        # @hint When/Then steps are in Present
        When I send a POST request to "/v1/consumable/biologic-test.json"
            """
            {"id": "1", "nbTestTube": 10}
            """
        Then the response status code should be 201
        And the supplier "Invitrogen" should be contacted to replenish "Platinum Blue Supermix" stocks

    Scenario: Successfully receive Biologic Test notification but don't contact Supplier to replenish stocks
        # @hint Given steps are in Present Continuous (ing)
        Given the laboratory always needing at least 40ml of "Platinum Blue Supermix" delivered by "Invitrogen"
        And the Testing Machine named "Thermocycler" consuming 22µl of "Platinum Blue Supermix" per test tube
        And the laboratory already having 40023µl of "Platinum Blue Supermix" in stock
        # @hint When/Then steps are in Present
        When I send a POST request to "/v1/consumable/biologic-test.json"
            """
            {"id": "1", "nbTestTube": 10}
            """
        Then the response status code should be 201
        And the supplier "Invitrogen" should not be contacted to replenish "Platinum Blue Supermix" stocks
