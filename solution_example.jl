function rebase(input_base, digits, output_base)
    if input_base < 2
        throw(DomainError("input_base must be at least 2."))
    end

    if output_base < 2
        throw(DomainError("output_base must be at least 2."))
    end


    i = 1
    while i ≤ length(digits)
        if digits[i] ≥ input_base  ||  digits[i] < 0
            msg = "all digits in input_base must be between " *
                  " and input_base - 1 inclusively."
            throw(DomainError(msg))
        end
        i += 1
    end

    ds = digits
    reverse!(ds)
    ∑ = 0
    for i =  1 : length(ds)
        ∑ += ds[i] * input_base^(i-1)
    end
    rem = ∑ # remainder

    dsNew = []
    while rem > 0
        push!(dsNew, rem % output_base)
        rem ÷= output_base
    end

    reverse!(dsNew)

    dsNew # returned
end
