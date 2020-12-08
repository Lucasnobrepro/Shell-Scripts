mkdir maiorque10
find -size +10M -type f -exec mv {} maiorque10/ \;
tar -czvf maiorque10.tar.gz  maiorque10/
rm -rf maiorque10/

