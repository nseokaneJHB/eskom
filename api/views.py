from django.http import JsonResponse
from django.utils import timezone
from django.views.decorators.http import require_http_methods


@require_http_methods(["GET"])
def health_check(request):
    return JsonResponse(
        {
            "method": request.method,
            "timestamp": timezone.now().isoformat(),
            "message": "Django + Vite + React + TypeScript + Tailwind is working!",
        }
    )
