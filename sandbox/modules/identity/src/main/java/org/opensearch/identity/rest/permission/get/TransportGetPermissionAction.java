/*
 * SPDX-License-Identifier: Apache-2.0
 *
 * The OpenSearch Contributors require contributions made to
 * this file be licensed under the Apache-2.0 license or a
 * compatible open source license.
 */

package org.opensearch.identity.rest.permission.get;

import org.opensearch.action.ActionListener;
import org.opensearch.action.support.ActionFilters;
import org.opensearch.action.support.HandledTransportAction;
import org.opensearch.common.inject.Inject;
import org.opensearch.identity.rest.service.PermissionService;
import org.opensearch.tasks.Task;
import org.opensearch.transport.TransportService;

public class TransportGetPermissionAction extends HandledTransportAction<GetPermissionRequest, GetPermissionResponse> {

    private final PermissionService permissionService;

    /**
     * Construct a new transport action for the get permission action. This will then be used to facilitate the execution of the request.
     * @param transportService OpenSearch's main transport service which handles operations on the transport layer
     * @param actionFilters Handles plugin action filter configurations
     * @param permissionService Executes the different permission operations
     */
    @Inject
    public TransportGetPermissionAction(
        TransportService transportService,
        ActionFilters actionFilters,
        PermissionService permissionService
    ) {
        super(GetPermissionAction.NAME, transportService, actionFilters, GetPermissionRequest::new);
        this.permissionService = permissionService;
    }

    /**
     * doExecute connects the transport layer permission service to the action request
     * @param task What OpenSearch is doing -- this is not needed for permission-related doExecute
     * @param request The request object that we want to perform
     * @param listener A listener that notifies the client about the execution progress
     */
    @Override
    protected void doExecute(Task task, GetPermissionRequest request, ActionListener<GetPermissionResponse> listener) {
        String username = request.getUsername();
        this.permissionService.getPermission(username, listener);
    }
}
