namespace DeutschAlgorithm {

open Microsoft.Quantum.Intrinsic;
open Microsoft.Quantum.Measurement;
open Microsoft.Quantum.Canon;
open Microsoft.Quantum.Random;

operation DeutschJozsaAlgorithm(f : ((Qubit[], Qubit) => Unit is Adj + Ctl)) : Bool {
    using (register = Qubit[2]) {

        ResetAll(register);

        H(register[0]);
        X(register[1]);
        H(register[1]);

        f([register[0]], register[1]);

        H(register[0]);

        let result = M(register[0]);

        ResetAll(register);

        return result == Zero;
    }
}


operation BalancedFunction(register : Qubit[], output : Qubit) : Unit is Adj + Ctl {

    CNOT(register[0], output);

}

operation ConstantFunction(register : Qubit[], output : Qubit) : Unit is Adj + Ctl {
}


operation DeutschAlgorithmCall(input : Bool) : Bool {
    if (input == true) {
        let constant = DeutschJozsaAlgorithm(ConstantFunction);
        return constant;
    }
    let balanced = DeutschJozsaAlgorithm(BalancedFunction);
    return balanced;
}

operation Main() : Unit {
    let randBool = DrawRandomBool(0.5);

    mutable message = "The function to test is balanced !";

    if (randBool) { set message = "The function to test is constant !"; }

   Message($"{message}");

    let isBalanced = DeutschAlgorithmCall(randBool);
    Message($"After having passed the algorithm, the function is balanced : {!isBalanced}");
}

}
