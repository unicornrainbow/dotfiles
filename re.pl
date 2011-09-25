use 5.012;
use warnings;
use Scalar::Util 'blessed', 'weaken';
use Scalar::Defer 'lazy', 'defer';

load_plugin qw(
    Colors
    Refresh
    Completion
    DumpHistory
    History
    LexEnv
    ReadLineHistory
    FancyPrompt
    Interrupt
);
