import Func "mo:base/Func";
import Text "mo:base/Text";
import Time "mo:base/Time";

import Random "mo:base/Random";
import Timer "mo:base/Timer";
import Nat8 "mo:base/Nat8";
import Debug "mo:base/Debug";
import Blob "mo:base/Blob";
import Array "mo:base/Array";
import Nat "mo:base/Nat";

actor {
    // Store the current random number
    stable var currentRandomNumber : Nat = 0;

    // Function to generate a new random number
    private func generateNewNumber() : async () {
        let entropy = await Random.blob();
        let randomBytes = Blob.toArray(entropy);
        if (randomBytes.size() > 0) {
            // Use the first byte to generate a number between 0 and 255
            currentRandomNumber := Nat8.toNat(randomBytes[0]);
        };
        Debug.print("Generated new random number: " # Nat.toText(currentRandomNumber));
    };

    // Initialize timer to generate new number every 30 seconds
    let timer = Timer.recurringTimer(#seconds 30, generateNewNumber);

    // Public query to get current random number
    public query func getCurrentNumber() : async Nat {
        currentRandomNumber
    };

    // System function to handle cleanup
    system func preupgrade() {
        // currentRandomNumber is already stable
    };

    system func postupgrade() {
        // Re-initialize timer after upgrade
        let _ = Timer.recurringTimer(#seconds 30, generateNewNumber);
    };
}
