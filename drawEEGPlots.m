

        clf;

        % draw the variance per channel plot
        subplot_tight(3,2,1,[0.05 0.05]);
        barwitherr(CIs(:,3),meanVariances);
        xlim([0.5 length(labels)+0.5]);
        xticks([1:1:length(labels)]);
        xtickangle(90);
        set(gca,'xticklabel',labels);
        title('Variance Per Second');

        % draw the artifact plot
        totalGradient = size(OUTEEG.data,3);
        subplot_tight(3,2,2,[0.05 0.05]);
        bar(artifactBarInfo);
        xlim([0.5 length(labels)+0.5]);
        ylim([0 100]);
        xticks([1:1:length(labels)]);
        xtickangle(90);
        set(gca,'xticklabel',labels);
        title({['Artifact Percentages (Gradient (Red): ' num2str(artifactCriteriaGradient) '   Difference (Blue): ' num2str(artifactCriteriaDifference) ')'],['Lost Gradient ' num2str(rejectedGradient) ':' num2str(totalGradient) '   Lost Difference ' num2str(rejectedDifference) ':' num2str(totalDifference)]});

        % imagesc plots of artifacts
        subplot_tight(3,2,3,[0.05 0.05]);
        imagesc(OUTEEG.artifactGradientSize',[0 artifactCriteriaGradient]);
        xticks([1:1:length(labels)]);
        xtickangle(90);
        set(gca,'xticklabel',labels);
        title('Gradient Artifacts by Channel and Trial');
        ylabel('Epochs');

        % imagesc plots of artifacts
        subplot_tight(3,2,4,[0.05 0.05]);
        imagesc(OUTEEG.artifactDifferenceSize',[0 artifactCriteriaDifference]);
        xticks([1:1:length(labels)]);
        xtickangle(90);
        set(gca,'xticklabel',labels);
        title('Difference Artifacts by Channel and Trial');
        ylabel('Epochs');

        % code to get marker count for each marker
        subplot_tight(3,2,5,[0.05 0.05]);
        bar(count);
        xticks([1:1:length(markers)]);
        xtickangle(90);
        set(gca,'xticklabel',markerLabels);
        title('Marker Counts');

 