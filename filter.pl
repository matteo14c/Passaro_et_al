while(<>)
{
	if ($_=~/^>/)
	{
		$id=$_;
	}else{
		chomp;
		$c{$id}.=$_
	}
}

foreach $f (keys %c)
{
	$seq=$c{$f};
	$seq=uc($seq);
	$l=length($seq);
	@vl=(split('',$seq));
	$C=0;
	foreach $v (@vl)
	{
		$C++ if $v eq "N";
		$C++ if $v=~/[ACGT]/;
	
	}
	chomp($f);
	$prop=$C/$l;
	#print "$f $prop\n";
	print "$f\_$prop\n$seq\n" if $prop<=0.15;
}
