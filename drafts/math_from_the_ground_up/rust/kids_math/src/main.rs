enum Digit {
    N0, N1, N2, N3, N4, N5, N6, N7, N8, N9
}

struct Result {
    value: Digit,
    carry: Digit
}

type Number = Vec<D>;

type D = Digit;
impl Result {
    fn digit(d: D) -> Self{
        Self {
            carry: D::N0,
            value: d
        }
    }
    fn teen(d: D) -> Self{
        Self {
            carry: D::N1,
            value: d
        }
    }
}
impl ToString for Digit {
    fn to_string(&self) -> String{
        match self {
            D::N0 => "0",
            D::N1 => "1",
            D::N2 => "2",
            D::N3 => "3",
            D::N4 => "4",
            D::N5 => "5",
            D::N6 => "6",
            D::N7 => "7",
            D::N8 => "8",
            D::N9 => "9"
        }.to_string()
    }
}

impl ToString for Result {
    fn to_string(&self) -> String{
        let mut carry = self.carry.to_string().to_owned();
        carry.push_str(&self.value.to_string().to_owned());
        carry
    }
}

impl ToString for Number {
    fn to_string(&self) -> String{
        let mut carry = self.carry.to_string().to_owned();
        carry.push_str(&self.value.to_string().to_owned());
        carry
    }
}

type R = Result;



fn mult_digit(d1: D, d2: D) -> R {
    match (d1, d2) {
        (D::N0, _) | (_, D::N0) => Result::digit(D::N0),
        (D::N1, n) | (n, D::N1) => Result::digit(n),
        (D::N2, n) | (n, D::N2) => match n {
            D::N2 => Result::digit(D::N4),
            D::N3 => Result::digit(D::N6),
            D::N4 => Result::digit(D::N8),
            D::N5 => Result {carry:D::N1, value:D::N0},
            D::N6 => Result {carry:D::N1, value:D::N2},
            D::N7 => Result {carry:D::N1, value:D::N4},
            D::N8 => Result {carry:D::N1, value:D::N6},
            D::N9 => Result {carry:D::N1, value:D::N8},
            _ => unreachable!()
        },
        (D::N3, n) | (n, D::N3) => match n {
            D::N3 => Result::digit(D::N9),
            D::N4 => Result {carry:D::N1, value:D::N2},
            D::N5 => Result {carry:D::N1, value:D::N5},
            D::N6 => Result {carry:D::N1, value:D::N8},
            D::N7 => Result {carry:D::N2, value:D::N1},
            D::N8 => Result {carry:D::N2, value:D::N4},
            D::N9 => Result {carry:D::N2, value:D::N7},
            _ => unreachable!()
        }
        (D::N4, n) | (n, D::N4) => match n {
            D::N4 => Result{carry:D::N1, value:D::N6},
            D::N5 => Result{carry:D::N2, value:D::N0},
            D::N6 => Result{carry:D::N2, value:D::N4},
            D::N7 => Result{carry:D::N2, value:D::N8},
            D::N8 => Result{carry:D::N3, value:D::N2},
            D::N9 => Result{carry:D::N3, value:D::N6},
            _ => unreachable!()
        }
        (D::N5, n) | (n, D::N5) => match n {
            D::N5 => Result{carry:D::N2, value:D::N5},
            D::N6 => Result{carry:D::N3, value:D::N0},
            D::N7 => Result{carry:D::N3, value:D::N5},
            D::N8 => Result{carry:D::N4, value:D::N0},
            D::N9 => Result{carry:D::N4, value:D::N5},
            _ => unreachable!()
        }
        (D::N6, n) | (n, D::N6) => match n {
            D::N6 => Result{carry:D::N3, value:D::N6},
            D::N7 => Result{carry:D::N4, value:D::N2},
            D::N8 => Result{carry:D::N4, value:D::N8},
            D::N9 => Result{carry:D::N5, value:D::N4},
            _ => unreachable!()
        }
        (D::N7, n) | (n, D::N7) => match n {
            D::N7 => Result{carry:D::N4, value:D::N9},
            D::N8 => Result{carry:D::N5, value:D::N6},
            D::N9 => Result{carry:D::N6, value:D::N3},
            _ => unreachable!()
        }
        (D::N8, n) | (n, D::N8) => match n {
            D::N8 => Result{carry:D::N6, value:D::N4},
            D::N9 => Result{carry:D::N7, value:D::N2},
            _ => unreachable!()
        }
        (D::N9, _) => Result{carry:D::N8, value:D::N1}
    }
}


fn add_digit(d1: D, d2: D) -> R {
    match (d1, d2) {
        (D::N0, n) | (n, D::N0) => Result::digit(n),
        (D::N1, n) | (n, D::N1) => match n {
            D::N1 => Result::digit(D::N2),
            D::N2 => Result::digit(D::N3),
            D::N3 => Result::digit(D::N4),
            D::N4 => Result::digit(D::N5),
            D::N5 => Result::digit(D::N6),
            D::N6 => Result::digit(D::N7),
            D::N7 => Result::digit(D::N8),
            D::N8 => Result::digit(D::N9),
            D::N9 => Result::teen(D::N0),
            _ => unreachable!()
        }
        (D::N2, n) | (n, D::N2) => match n {
            D::N2 => Result::digit(D::N4),
            D::N3 => Result::digit(D::N5),
            D::N4 => Result::digit(D::N6),
            D::N5 => Result::digit(D::N7),
            D::N6 => Result::digit(D::N8),
            D::N7 => Result::digit(D::N9),
            D::N8 => Result::teen(D::N0),
            D::N9 => Result::teen(D::N1),
            _ => unreachable!()
        },
        (D::N3, n) | (n, D::N3) => match n {
            D::N3 => Result::digit(D::N6),
            D::N4 => Result::digit(D::N7),
            D::N5 => Result::digit(D::N8),
            D::N6 => Result::digit(D::N9),
            D::N7 => Result::teen(D::N0),
            D::N8 => Result::teen(D::N1),
            D::N9 => Result::teen(D::N2),
            _ => unreachable!()
        }
        (D::N4, n) | (n, D::N4) => match n {
            D::N4 => Result::digit(D::N8),
            D::N5 => Result::digit(D::N9),
            D::N6 => Result::teen(D::N0),
            D::N7 => Result::teen(D::N1),
            D::N8 => Result::teen(D::N2),
            D::N9 => Result::teen(D::N3),
            _ => unreachable!()
        }
        (D::N5, n) | (n, D::N5) => match n {
            D::N4 => Result::digit(D::N9),
            D::N5 => Result::teen(D::N0),
            D::N6 => Result::teen(D::N1),
            D::N7 => Result::teen(D::N2),
            D::N8 => Result::teen(D::N3),
            D::N9 => Result::teen(D::N4),
            _ => unreachable!()
        }
        (D::N6, n) | (n, D::N6) => match n {
            D::N6 => Result::teen(D::N2),
            D::N7 => Result::teen(D::N3),
            D::N8 => Result::teen(D::N4),
            D::N9 => Result::teen(D::N5),
            _ => unreachable!()
        }
        (D::N7, n) | (n, D::N7) => match n {
            D::N7 => Result::teen(D::N4),
            D::N8 => Result::teen(D::N5),
            D::N9 => Result::teen(D::N6),
            _ => unreachable!()
        }
        (D::N8, n) | (n, D::N8) => match n {
            D::N8 => Result::teen(D::N6),
            D::N9 => Result::teen(D::N7),
            _ => unreachable!()
        }
        (D::N9, _) => Result::teen(D::N8)
    }
}

fn main() {
    println!("{}", add_digit(D::N3, D::N7).to_string());
    println!("{}", vec![D::N1, D::N2, D::N3].to_string());
}
