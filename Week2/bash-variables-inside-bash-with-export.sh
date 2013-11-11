#! /bin/bash
export variable=test

echo within first shell \(pid $$\): \$variable=$variable
bash -c 'echo within second shell \(pid $$\) \$variable=$variable'