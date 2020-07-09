$sam_viral_file=shift;
die("input file not found\n") unless -e $sam_viral_file;
open(IN,$sam_viral_file);
open(OUT,">$sam_viral_file\_singleton.fq");
open(OUT2,">$sam_viral_file\_partial.fq");

while(<IN>)
{
	next if $_=~/^@/;
	$r2=<IN>;
	($id1,$pos_r1,$cigar_r1,$seq_r1,$q_r1)=(split(/\t/,$_))[0,2,5,9,10];#[2,5,9,10]
	($id2,$pos_r2,$cigar_r2,$seq_r2,$q_r2)=(split(/\t/,$r2))[0,2,5,9,10];
	$lm1=length($seq_r1)."M";
	$lm2=length($seq_r2)."M";
	next if( $pos_r1 eq $pos_r2 & $cigar_r1 eq $lm1 & $cigar_r2 eq $lm2);
	print "$pos_r1 $pos_r2\n" if $pos_r1 ne $pos_r2;
	if ($pos_r1 eq "*" && $pos_r2 ne "*")
	{
		print OUT "\@$id1\n$seq_r1\n+$id1\n$q_r1\n";
		next;
	}elsif($pos_r1 ne "*" && $pos_r2 eq "*"){
		print OUT "\@$id2\n$seq_r2\n+$id2\n$q_r2\n";
		next;
	}
	if ($cigar_r1 ne $lm1)
	{
		@num=split(/\D+/,$cigar_r2);
        	@lett=split(/\d+/,$cigar_r2);
		shift(@lett);
        	$M=0;
        	for ($i=0;$i<=$#num;$i++)
        	{
                	$M+=$num[$i] if $lett[$i] eq "M";
       		}
		$prop=$M/length($seq_r1);
		if ($prop>=0.35 && $prop<=0.65)
		{
			print OUT2 "\@$id1\n$seq_r1\n+$id1\n$q_r1\n";
		}

	}
	if ($cigar_r2 ne $lm2)
	{
		@num=split(/\D+/,$cigar_r2);
        	@lett=split(/\d+/,$cigar_r2);
		$M=0;
                for ($i=0;$i<=$#num;$i++)
                {
                        $M+=$num[$i] if $lett[$i] eq "M";
                }
                $prop=$M/length($seq_r1);
                if ($prop>=0.35 && $prop<=0.65)
                {
                        print OUT2 "\@$id2\n$seq_r2\n+$id2\n$q_r2\n";
                }
	}	
}
