function [ mat3 ] = mat_mul( mat1, mat2, R1, C1, C2 )

    ROW1 = R1;
    COL1 = C1;
    COL2 = C2;
    %ROW2 = COL1;

    %N1 = ROW1*COL1;
    %N2 = ROW2*COL2;
    %N3 = ROW1*COL2;
    temp = 0;

    for j=0:1:ROW1-1
        for k=0:1:COL2-1
            for l=0:1:COL1-1
                temp = temp + (mat1(l+j*COL1+1))*(mat2(k+l*COL2+1));
            end
            mat3(k+j*COL2+1) = temp;
            temp = 0;
        end
    end

end
