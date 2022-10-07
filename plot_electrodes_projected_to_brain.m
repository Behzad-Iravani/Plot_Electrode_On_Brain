function plot_electrodes_projected_to_brain(electrodeMNI, vert, hemi, view, JPlable, szx, col, type)
% This function plots electrod projection on the brain

switch view
    case 'medial'
        projection = 2;  % loc_view(90, 0)
    case 'lateral'
        projection = 2;
    case 'anterior'
        projection = 1;
    case 'posterior'
        loc_view(0,0)
    case 'ventral'
        projection = 2;
    case 'temporal'
        projection = 2;
    case 'dorsal'
        projection = 2;
    case 'latero-ventral'
        projection = 2;
    case 'medio-dorsal'
        projection = 2;
    case 'medio-ventral'
        projection = 2;
    case 'medio-posterior'
        projection = 2;
    case 'medio-anterior'
        projection = 2;
    case 'frontal'
        projection = 1;
    case 'parietal'
        projection = 2;
end


for i  = 1:size(electrodeMNI,1)
    if projection == 1
        x = electrodeMNI(i,1);
        y = max(vert(:,2));
        z = electrodeMNI(i,3);
    elseif projection == 2
        switch view
            case 'medial'
                x = 0;
                y = electrodeMNI(i,2);
                z = electrodeMNI(i,3);
                if ~isempty(JPlable{i})
                    flag_remove(i) = ~any(cellfun(@(x) strcmp(x,'MPFC') | strcmp(x,'MFC'), JPlable{i}));
                else
                    flag_remove(i) = false;
                end
                if ~flag_remove(i)

                    label{i} = 'MFC';
                else
                    label{i} = nan;
                end
            case 'ventral'
                x = electrodeMNI(i,1);
                y = electrodeMNI(i,2);
                z = min(vert(:,3));
                if ~isempty(JPlable{i})
                    flag_remove(i) = ~any(cellfun(@(x) strcmp(x,'OFC'), JPlable{i}));
                else
                    flag_remove(i) = false;
                end
                if ~flag_remove(i)

                    label{i} = 'OFC';
                else
                    label{i} = nan;
                end
                %                 abs(min(MNI_surface.(hemi{:}).cortex.vert(:,3)) -...
                %                 electrodeMNI(i,3))>50;
        end

    else
        x = electrodeMNI(i,1);
        y = electrodeMNI(i,2);
        z = min(MNI_surface.(hemi{:}).cortex.vert(idx,3));
    end

    if strcmp(hemi{:},'right') && electrodeMNI(i,1)>0
        if strcmp(type, 'open')
            scatter3(x,y,z,szx,'filled', 'MarkerEdgeColor', col, 'MarkerFaceColor', 'none');
        elseif strcmp(type, 'close')
            scatter3(x,y,z,szx,'filled', 'MarkerEdgeColor', 'none', 'MarkerFaceColor', col);

        else
            error('undefined type, chose either "type = close" or "type = open"')
        end
    elseif strcmp(hemi{:},'left') && electrodeMNI(i,1)<0
        if strcmp(type, 'open')
            scatter3(x,y,z,szx,'filled','MarkerEdgeColor', col, 'MarkerFaceColor', 'none');
        elseif strcmp(type, 'close')
            scatter3(x,y,z,szx,'filled', 'MarkerEdgeColor', 'none', 'MarkerFaceColor', col);
        else
            error('undefined type, chose either "type = close" or "type = open"')
        end
    end

end
