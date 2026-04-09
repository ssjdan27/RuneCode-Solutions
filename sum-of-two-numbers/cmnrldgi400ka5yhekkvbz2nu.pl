my $input = do { local $/; <STDIN> };
my ($a, $b) = split /\s+/, $input;
print $a + $b, "\n";