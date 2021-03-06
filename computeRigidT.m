function [ transformation ] = computeRigidT( points1, points2 )
%COMPUTERIGIDTRANSFORMATION Computers a rigid transformation from points1
%to points2
%   This functions assumes that all points are inliers and uses SVD to
%   compute the best transformation. 
    nPoints = size(points1, 1);
    dimension = size(points1, 2);
    
    centroid1 = sum(points1, 1)./nPoints;
    centroid2 = sum(points2, 1)./nPoints;
    
    centered1 = points1 - repmat(centroid1, nPoints, 1);
    centered2 = points2 - repmat(centroid2, nPoints, 1);
    
    W = eye(nPoints, nPoints);
    
    S = centered1' * W * centered2;
    
    [U, Sigma, V] = svd(S);
    
    M = eye(dimension, dimension);
    M(dimension, dimension) = det(V*U');
    
    R = V * M * U';
    t = centroid2' - R*centroid1';
    
    transformation = eye(4,4);
    transformation(1:3, 1:3) = R;
    transformation(1:3, 4) = t;
end
