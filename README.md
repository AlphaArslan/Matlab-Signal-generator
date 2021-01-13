# Matlab Signal Generator #
We enable the user to define a signal to plot, and an operation to perform on that signal.

![Signal Demo](https://github.com/AlphaArslan/Matlab-Signal-generator/blob/master/img/signal_demo.jpg?raw=true)

 - - - - -
 ## Table of Contents:
 - [Supported Function Definitions](#Supported-Function-Definitions):
    - [DC Signal](#DC-Signal).
    - [Ramp Signal](#Ramp-Signal).
    - [General Order Polynomial](#General-Order-Polynomial).
    - [Exponential Signal](#Exponential-Signal).
    - [Sinusoidal Signal](#Sinusoidal-Signal).
 - [Supported Signal Operations](#Supported-Signal-Operations):
    - [Amplitude Scaling](#Amplitude-Scaling).
    - [Time Reversal](#Time-Reversal).
    - [Time Shift](#Time-Shift).
    - [Time Scaling](#Time-Scaling):
        - [Time Expansion](#Time-Expansion).
        - [Time Compression](#Time-Compression).
 - [Demo and Tutorial](#Demo-and-Tutorial)

- - - - -
## Supported Function Definitions
We provide the user with different functions/signal definitions. The user may user some or all of those functions to compose the signal of interest.
Each function definition may require a certain number of parameters depending on the definition itself. Each function is detailed as follows.

### DC Signal
__x[t] = A__<br>
As __A__ is constant. Apparently, this function definition takes only one parameter: __A__.

### Ramp Signal
__x[t] = A * t + B__<br>
Here we have two parameters: __A__ and __B__.

### General Order Polynomial
__x[t] = A(n) * t^(n) + A(n-1) * t^(n-1) + ... + A(0)__<br>
This function __n + 1__ parameters, which are __A(n), A(n-1), ..., A(0)__.

### Exponential Signal
__x[t] = A * e^(B * t)__<br>
Here we have two parameters: __A__ and __B__.
> Note: Of course, we could added one more parameter to represent the intercept such that __x[t] = A * e^(B * t) + C__. However, we are following the [problem statement](https://github.com/AlphaArslan/Matlab-Signal-generator/blob/master/Problem/mini-project-1.pdf) to the letter.

### Sinusoidal Signal
__x[t] = A * sin(2 * pi * F * t + P)__<br>
__A__ represents the Amplitude.<br>
__F__ represents the frequency _in Hz_.<br>
__P__ represents the phase _in radians_.<br>

## Supported Signal Operations
After drawing/plotting the signal, the user is allowed to perform certain operations on the signal. The user can do any of those operation for any number of times. The supported signal operations are as follows.

### Amplitude Scaling
__y[t] = A * x[t]__<br>
__A__ is the amplitude scale factor.

### Time Reversal
__y[t] = x[-t]__<br>
Apparently, no parameter is asked for. The operation is fully defined.

### Time Shift
__y[t] = x[t - T]__<br>
__T__ defines how much shift to the right _in seconds_ should take place.

### Time Scaling
__y[t] = x[A * t]__<br>
This operation manipulates the _t axis_ in a manner that expands or compresses the original signal.
#### Time Expansion
This is a sub-operation of time scaling, where __0 < A < 1__.
#### Time Compression
This is a sub-operation of time scaling, where __1 < A__.

>NOTE: no actual need to use sub-operations for time scaling as all variations can be achieved through the value of __A__. However, again, we choose to follow the problem statement to the letter. We don't need to get anyone in the teaching staff offended :wink: :wink:.

## Demo and Tutorial
A [YouTube Playlist](https://www.youtube.com/watch?v=iZtJm0G5PE4&list=PLVTXC7QFRDzqUeJxwqGO58LoilPx6BsM0) has been done. It gives full explanation even to the finest details. The Tutorial is in __Arabic__ but subtitles are expected.<br>
<br>

[![IMAGE ALT TEXT HERE](https://img.youtube.com/vi/iZtJm0G5PE4/0.jpg)](https://www.youtube.com/watch?v=iZtJm0G5PE4)

<br>
Also, refer to the (report)[https://github.com/AlphaArslan/Matlab-Signal-generator/blob/master/report/report.pdf] to find a demo on how to produce the signal in the image above and how to do variant operations on it.

### Contributions
This project wouldn't come to existence if it wasn't for the great contribution of my teammates.
The code was tested by my teammates:
- [@fizards12](https://github.com/fizards12)
- [@princesiefshama](https://github.com/princesiefshama)

The report was done by:
- [@Mohamedtarek1998](https://github.com/Mohamedtarek1998)
