while(<>)
{
	$nline=8;
	if ($_=~/Query=(.*)/)
	{
		$id=$1;
		($len,$cov)=(split(/\_/,$id))[3,5];
		for ($i=1;$i<=$nline;$i++)
		{
			$line=<>;
			next if $line=~/significant/;
			chomp($line);
			if ($line=~/No hits found/)
			{
				#print "$id\t$line\n";
				$Hist{"Nohit"}++;
				$TotL{"Nohit"}+=$len;
			}else{
				@vl=(split(/\s+/,$line));
				$desc="";
				for ($j=1;$j<=$#vl;$j++)
				{
					$desc.="$vl[$j] " unless $vl[$j]=~/\d+/;
					last if $vl[$j]=~/\d+/;
				}
				next unless $#vl>=4;
				next unless $vl[-1]<=1e-5;
				$desc=lc($desc);
				if ($desc=~/sapiens/ || $desc=~/human/)
				{
					$Hist{"human"}++;
					$TotL{"human"}+=$len;
				}elsif ($desc=~/callithrix/ || $desc=~/theropithecus/ || $desc=~// || $desc=~/pan/ || $desc=~/gorilla/ || $desc=~/mandrillus/ || $desc=~/macaca/ || $desc=~/pongo/ || $desc=~/papio/ || $desc=~/nomascus/ ){
					$Hist{"monkey"}++;
					$TotL{"monkey"}+=$len;
				}elsif ($desc=~/mus/){
					$Hist{"mouse"}++;
					$TotL{"mouse"}+=$len;
				}else{
					@d=(split(/\s+/,$desc));
					$desc="$d[0]\_$d[1]";
					$desc=lc $desc;
					$Hist{$desc}++;
					$TotL{$desc}+=$len;
					#print "$id\t$desc\t$vl[-1]\n"; 
				}
			}	
		}
		#print "\n";
	}
}

foreach $d (keys %Hist)
{
	print "$d\t$Hist{$d}\t$TotL{$d}\n";
}
